
mjolnir
-------

The point of this package is to flatten recursive objects into tidy\[ish\] data frames whilst preserving maximum amount of information and using as little time as possible.

Demo
----

``` r
## get some nested data
library(rtweet)
```

    ## Welcome to rtweet v0.4.7!

``` r
rt <- search_tweets("lang:en", n = 300, parse = FALSE)
```

    ## Searching for tweets...

    ## Finished collecting tweets!

``` r
rt <- lapply(rt, "[[", "statuses")

## check the structure
str(rt, 2, vec.len = 0)
```

    ## List of 3
    ##  $ :'data.frame':    100 obs. of  31 variables:
    ##   ..$ created_at               : chr [1:100]  ...
    ##   ..$ id                       : num [1:100] NULL ...
    ##   ..$ id_str                   : chr [1:100]  ...
    ##   ..$ text                     : chr [1:100]  ...
    ##   ..$ truncated                : logi [1:100] NULL ...
    ##   ..$ display_text_range       :List of 100
    ##   ..$ entities                 :'data.frame':    100 obs. of  5 variables:
    ##   ..$ metadata                 :'data.frame':    100 obs. of  2 variables:
    ##   ..$ source                   : chr [1:100]  ...
    ##   ..$ in_reply_to_status_id    : num [1:100] NULL ...
    ##   ..$ in_reply_to_status_id_str: chr [1:100]  ...
    ##   ..$ in_reply_to_user_id      : num [1:100] NULL ...
    ##   ..$ in_reply_to_user_id_str  : chr [1:100]  ...
    ##   ..$ in_reply_to_screen_name  : chr [1:100]  ...
    ##   ..$ user                     :'data.frame':    100 obs. of  42 variables:
    ##   ..$ geo                      :'data.frame':    100 obs. of  2 variables:
    ##   ..$ coordinates              :'data.frame':    100 obs. of  2 variables:
    ##   ..$ place                    :'data.frame':    100 obs. of  10 variables:
    ##   ..$ contributors             : logi [1:100] NULL ...
    ##   ..$ retweeted_status         :'data.frame':    100 obs. of  30 variables:
    ##   ..$ is_quote_status          : logi [1:100] NULL ...
    ##   ..$ retweet_count            : int [1:100] NULL ...
    ##   ..$ favorite_count           : int [1:100] NULL ...
    ##   ..$ favorited                : logi [1:100] NULL ...
    ##   ..$ retweeted                : logi [1:100] NULL ...
    ##   ..$ lang                     : chr [1:100]  ...
    ##   ..$ possibly_sensitive       : logi [1:100] NULL ...
    ##   ..$ extended_entities        :'data.frame':    100 obs. of  1 variable:
    ##   ..$ quoted_status_id         : num [1:100] NULL ...
    ##   ..$ quoted_status_id_str     : chr [1:100]  ...
    ##   ..$ quoted_status            :'data.frame':    100 obs. of  27 variables:
    ##  $ :'data.frame':    100 obs. of  31 variables:
    ##   ..$ created_at               : chr [1:100]  ...
    ##   ..$ id                       : num [1:100] NULL ...
    ##   ..$ id_str                   : chr [1:100]  ...
    ##   ..$ text                     : chr [1:100]  ...
    ##   ..$ truncated                : logi [1:100] NULL ...
    ##   ..$ display_text_range       :List of 100
    ##   ..$ entities                 :'data.frame':    100 obs. of  5 variables:
    ##   ..$ metadata                 :'data.frame':    100 obs. of  2 variables:
    ##   ..$ source                   : chr [1:100]  ...
    ##   ..$ in_reply_to_status_id    : num [1:100] NULL ...
    ##   ..$ in_reply_to_status_id_str: chr [1:100]  ...
    ##   ..$ in_reply_to_user_id      : num [1:100] NULL ...
    ##   ..$ in_reply_to_user_id_str  : chr [1:100]  ...
    ##   ..$ in_reply_to_screen_name  : chr [1:100]  ...
    ##   ..$ user                     :'data.frame':    100 obs. of  42 variables:
    ##   ..$ geo                      : logi [1:100] NULL ...
    ##   ..$ coordinates              : logi [1:100] NULL ...
    ##   ..$ place                    :'data.frame':    100 obs. of  10 variables:
    ##   ..$ contributors             : logi [1:100] NULL ...
    ##   ..$ retweeted_status         :'data.frame':    100 obs. of  30 variables:
    ##   ..$ is_quote_status          : logi [1:100] NULL ...
    ##   ..$ retweet_count            : int [1:100] NULL ...
    ##   ..$ favorite_count           : int [1:100] NULL ...
    ##   ..$ favorited                : logi [1:100] NULL ...
    ##   ..$ retweeted                : logi [1:100] NULL ...
    ##   ..$ lang                     : chr [1:100]  ...
    ##   ..$ possibly_sensitive       : logi [1:100] NULL ...
    ##   ..$ extended_entities        :'data.frame':    100 obs. of  1 variable:
    ##   ..$ quoted_status_id         : num [1:100] NULL ...
    ##   ..$ quoted_status_id_str     : chr [1:100]  ...
    ##   ..$ quoted_status            :'data.frame':    100 obs. of  27 variables:
    ##  $ :'data.frame':    100 obs. of  31 variables:
    ##   ..$ created_at               : chr [1:100]  ...
    ##   ..$ id                       : num [1:100] NULL ...
    ##   ..$ id_str                   : chr [1:100]  ...
    ##   ..$ text                     : chr [1:100]  ...
    ##   ..$ truncated                : logi [1:100] NULL ...
    ##   ..$ display_text_range       :List of 100
    ##   ..$ entities                 :'data.frame':    100 obs. of  5 variables:
    ##   ..$ metadata                 :'data.frame':    100 obs. of  2 variables:
    ##   ..$ source                   : chr [1:100]  ...
    ##   ..$ in_reply_to_status_id    : num [1:100] NULL ...
    ##   ..$ in_reply_to_status_id_str: chr [1:100]  ...
    ##   ..$ in_reply_to_user_id      : num [1:100] NULL ...
    ##   ..$ in_reply_to_user_id_str  : chr [1:100]  ...
    ##   ..$ in_reply_to_screen_name  : chr [1:100]  ...
    ##   ..$ user                     :'data.frame':    100 obs. of  42 variables:
    ##   ..$ geo                      : logi [1:100] NULL ...
    ##   ..$ coordinates              : logi [1:100] NULL ...
    ##   ..$ place                    :'data.frame':    100 obs. of  10 variables:
    ##   ..$ contributors             : logi [1:100] NULL ...
    ##   ..$ is_quote_status          : logi [1:100] NULL ...
    ##   ..$ retweet_count            : int [1:100] NULL ...
    ##   ..$ favorite_count           : int [1:100] NULL ...
    ##   ..$ favorited                : logi [1:100] NULL ...
    ##   ..$ retweeted                : logi [1:100] NULL ...
    ##   ..$ possibly_sensitive       : logi [1:100] NULL ...
    ##   ..$ lang                     : chr [1:100]  ...
    ##   ..$ retweeted_status         :'data.frame':    100 obs. of  30 variables:
    ##   ..$ extended_entities        :'data.frame':    100 obs. of  1 variable:
    ##   ..$ quoted_status_id         : num [1:100] NULL ...
    ##   ..$ quoted_status_id_str     : chr [1:100]  ...
    ##   ..$ quoted_status            :'data.frame':    100 obs. of  28 variables:

``` r
## hammer time
library(mjolnir)

mjolnir.list(rt)
```

    ## # A tibble: 300 x 535
    ##    contributors                     created_at
    ##           <chr>                          <chr>
    ##  1         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  2         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  3         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  4         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  5         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  6         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  7         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  8         <NA> Sat Jul 15 13:36:04 +0000 2017
    ##  9         <NA> Sat Jul 15 13:36:04 +0000 2017
    ## 10         <NA> Sat Jul 15 13:36:04 +0000 2017
    ## # ... with 290 more rows, and 533 more variables:
    ## #   display_text_range <chr>, entities.hashtags.indices <chr>,
    ## #   entities.hashtags.text <chr>, entities.media.display_url <chr>,
    ## #   entities.media.expanded_url <chr>, entities.media.id <chr>,
    ## #   entities.media.id_str <chr>, entities.media.indices <chr>,
    ## #   entities.media.media_url <chr>, entities.media.media_url_https <chr>,
    ## #   entities.media.sizes.large.h <chr>,
    ## #   entities.media.sizes.large.resize <chr>,
    ## #   entities.media.sizes.large.w <chr>,
    ## #   entities.media.sizes.medium.h <chr>,
    ## #   entities.media.sizes.medium.resize <chr>,
    ## #   entities.media.sizes.medium.w <chr>,
    ## #   entities.media.sizes.small.h <chr>,
    ## #   entities.media.sizes.small.resize <chr>,
    ## #   entities.media.sizes.small.w <chr>,
    ## #   entities.media.sizes.thumb.h <chr>,
    ## #   entities.media.sizes.thumb.resize <chr>,
    ## #   entities.media.sizes.thumb.w <chr>,
    ## #   entities.media.source_status_id <chr>,
    ## #   entities.media.source_status_id_str <chr>,
    ## #   entities.media.source_user_id <chr>,
    ## #   entities.media.source_user_id_str <chr>, entities.media.type <chr>,
    ## #   entities.media.url <chr>, entities.urls.display_url <chr>,
    ## #   entities.urls.expanded_url <chr>, entities.urls.indices <chr>,
    ## #   entities.urls.url <chr>, entities.user_mentions.id <chr>,
    ## #   entities.user_mentions.id_str <chr>,
    ## #   entities.user_mentions.indices <chr>,
    ## #   entities.user_mentions.name <chr>,
    ## #   entities.user_mentions.screen_name <chr>,
    ## #   extended_entities.media.additional_media_info.monetizable <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.contributors_enabled <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.created_at <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.default_profile <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.default_profile_image <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.description <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.entities.url.urls.display_url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.entities.url.urls.expanded_url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.entities.url.urls.indices <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.entities.url.urls.url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.favourites_count <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.follow_request_sent <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.followers_count <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.following <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.friends_count <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.geo_enabled <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.has_extended_profile <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.id <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.id_str <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.is_translation_enabled <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.is_translator <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.lang <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.listed_count <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.location <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.name <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.notifications <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_background_color <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_background_image_url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_background_image_url_https <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_background_tile <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_banner_url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_image_url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_image_url_https <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_link_color <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_sidebar_border_color <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_sidebar_fill_color <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_text_color <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.profile_use_background_image <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.protected <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.screen_name <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.statuses_count <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.time_zone <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.translator_type <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.url <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.utc_offset <chr>,
    ## #   extended_entities.media.additional_media_info.source_user.verified <chr>,
    ## #   extended_entities.media.display_url <chr>,
    ## #   extended_entities.media.expanded_url <chr>,
    ## #   extended_entities.media.id <chr>,
    ## #   extended_entities.media.id_str <chr>,
    ## #   extended_entities.media.indices <chr>,
    ## #   extended_entities.media.media_url <chr>,
    ## #   extended_entities.media.media_url_https <chr>,
    ## #   extended_entities.media.sizes.large.h <chr>,
    ## #   extended_entities.media.sizes.large.resize <chr>,
    ## #   extended_entities.media.sizes.large.w <chr>,
    ## #   extended_entities.media.sizes.medium.h <chr>,
    ## #   extended_entities.media.sizes.medium.resize <chr>,
    ## #   extended_entities.media.sizes.medium.w <chr>,
    ## #   extended_entities.media.sizes.small.h <chr>,
    ## #   extended_entities.media.sizes.small.resize <chr>,
    ## #   extended_entities.media.sizes.small.w <chr>,
    ## #   extended_entities.media.sizes.thumb.h <chr>, ...
