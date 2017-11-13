# Accessibility Analysis

## Feature Roadmap

* Page features
    * Timeouts
    * Post load wait-times
    * Scripts (reusable)
    * User/pass for http auth
    * Headers
    * Cookies (because writing them as a header is a pain).
    * Ignore elements by css selector
    * Ignore rules
    * Graph messages and severity over time
    * Consider page variants or maybe multiple pages
        * Allow different combinations of cookies, headers, scripts, user/pass, etc.
    * Compare two analyses for the (same page? or variants on a single page?)
        * Did any elements move?
        * Do any elements look different?
            * Store computed styles or chop out an image of the thing.
        * Which elements are in one but not the other?
* Analysis features
    * Track which version of what is used to run the test
        * Chrome
        * Ruby
        * selenium-webdriver gem
        * ?
    * Track which version of the target is being tested
        * Look at a git repository?
        * Look at a header in the responses?
    * Mark a rule / path combination as checked (different from ignored)
        * Hide it from future analyses on the same page
        * Figure out a way to tell when it needs to be rechecked.
