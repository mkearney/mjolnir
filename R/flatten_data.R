
atomics <- function(x) x[vapply(x, is.atomic, logical(1))]
recursives <- function(x) x[vapply(x, is.recursive, logical(1))]

#' mjolnir generic
#'
#' @param .data Data to be smashed.
#' @export
mjolnir <- function(.data) .data

#' default
#'
#' @param .data
#' @export
mjolnir.default <- function(.data) {
  atms <- atomics(.data)
  recs <- recursives(.data)
  attr(atms, "recursives") <- recs
  atms
}


#' mjolnir
#'
#' By the Hammer of Thor!
#'
#' @param x Data in nested form.
#' @param obj Optional, name of nested object you'd like to hammer throw.
#'   Useful if there's metadata/other top-level object you'd like to ignore.
#'   Of if you just want to make sure the correct data is flattend.
#' @return A hammered data frame.
#' @export
mjolnir.data.frame <- function(x, obj = NULL) {
  stopifnot(is.recursive(x))
  if (!is.null(obj)) {
    if (!is.data.frame(x) && grepl(obj, names(x))) {
      x <- x[[grep("^status", names(x))]]
    }
  }
  ## iterate by row
  x <- lapply(
    seq_len(nrow(x)),
    function(i) cleanupunlistdataframers(x[i, ])
  )
  ## all vars
  uqs <- unique(unlist(lapply(x, names)))
  uqs <- uqs[uqs != ""]
  kpall <- structure(
    rep(NA, length(uqs)),
    names = uqs
  )
  x <- lapply(x, function(z) {
    z <- c(z, kpall[!names(kpall) %in% names(z)])
    z <- z[names(z) != ""]
    ## order may not be necessary but it's handy
    z <- z[order(names(z))]
    z
  })
  ## a tbl built for speed
  tibble::as_tibble(list(do.call("rbind", x)), validate = FALSE)
}

mjolnir.list <- function(x) {
  stopifnot(is.recursive(x))
  ## peel back empty list wrapper
  if (length(x) == 1 && !is.data.frame(x) && is.recursive(x)) {
    x <- x[[1]]
  }
  ## if obj or vectorized
  if (is.data.frame(x)) {
    return(mjolnir(x))
  }
  ## if vectorized then compile all vars, select the common ones, and
  ## row bind into data frame
  x <- lapply(x, mjolnir)
  nms <- table(unlist(lapply(x, names)))
  if (length(unique(nms)) > 1L) {
    kprs <- names(nms[nms == max(nms, na.rm = TRUE)])
    x <- lapply(x, function(i) return(i[names(i) %in% kprs]))
  }
  do.call("rbind", x)
}

as_data.frame <- function(x) {
  ## hammer into data frame
  if (!is.data.frame(x)) {
    x <- tryCatch(
      as.data.frame(x),
      function(e) error = return(NULL))
    if (is.null(x)) return(data.frame())
  }
  x
}


tblnames <- function(x, n = 10) {
  ## if n is positive, then return most common
  if (sign(n) == 1) {
    sort(table(unlist(lapply(tml, names))),
         decreasing = TRUE)[seq_len(n)]
  } else {
    ##if n is negative, return least common
    sort(table(unlist(lapply(tml, names))))[rev(seq_len(abs(n)))]
  }
}

cleanupunlistdataframers <- function(x) {
  ## unlist with names & drop unnamed
  x <- unlist(x)
  x <- x[names(x) != ""]
  ## if numbers added to ends, paste values together
  nms <- gsub("[[:digit:]]{1,}$", "", names(x))
  nmstb <- table(nms)
  dup <- names(nmstb[nmstb > 1L])
  y1 <- x[!nms %in% dup]
  y2 <- vapply(dup, function(i)
    paste(x[!nms %in% i], collapse = " "),
    character(1))
  ## return all
  c(y1, y2)
}



