Sort-quire
==========

Plugin to sort require of Clojure(Script) files.

Installation
------------
[vim-plug](https://github.com/junegunn/vim-plug)

`Plug 'paulojean/sort-quire.vim'`

Usage
------------
Just call `:SortQuire`

```clj
; Before
(ns leiningen.figwheel
  (:refer-clojure :exclude [test])
  (:require [leiningen.core.eval :as leval]
            [leiningen.clean :as clean]
            [leiningen.core.main :as main]
            [clojure.java.io :as io]
            [clojure.set :refer [intersection]]
            [leiningen.figwheel.fuzzy :as fuz]
            [simple-lein-profile-merge.core :as lm])
  (:import [java.time LocalDateTime]
           [java.util UUID]
           [com.google.api.client.http.javanet NetHttpTransport]))
            
; After
(ns leiningen.figwheel
  (:refer-clojure :exclude [test])
  (:require [clojure.java.io :as io]
            [clojure.set :refer [intersection]]
            [leiningen.clean :as clean]
            [leiningen.core.eval :as leval]
            [leiningen.core.main :as main]
            [leiningen.figwheel.fuzzy :as fuz]
            [simple-lein-profile-merge.core :as lm])
  (:import [com.google.api.client.http.javanet NetHttpTransport]
           [java.time LocalDateTime]
           [java.util UUID]))
```
