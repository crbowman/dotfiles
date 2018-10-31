;; Fonts
(defconst my-font-size (cond ((<= 3840 (display-pixel-width)) 20)
                             ((<= 2560 (display-pixel-width)) 16)
                             ((<= 1980 (display-pixel-width)) 14)
                             ((<= 1440 (display-pixel-width)) 12)))

(setq-default dotspacemacs-default-font `("Source Code Pro"
                                          :size ,my-font-size
                                          :weight normal
                                          :height normal))
