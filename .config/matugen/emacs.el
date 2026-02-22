(defun hesam/parse-hsl (hsl-string)
  "Helper to turn hsl(H, S%, L%) into a list of (H S L) as decimals."
  (if (string-match "hsl(\\([0-9.]+\\), \\([0-9.]+\\)%, \\([0-9.]+\\)%)" hsl-string)
      (list (/ (string-to-number (match-string 1 hsl-string)) 360.0)
            (/ (string-to-number (match-string 2 hsl-string)) 100.0)
            (/ (string-to-number (match-string 3 hsl-string)) 100.0))
    nil))


(defun hesam/pick-ef-theme-by-hsl (primary-hsl surface-hsl)
  "Pick ef-theme using primary color for hue and surface color for light/dark."
  (require 'ef-themes)
  (let* ((primary (my/parse-hsl primary-hsl))
         (surface (my/parse-hsl surface-hsl))
         (hue (nth 0 primary))
         (sat (nth 1 primary))
         (bg-light (nth 2 surface))
         theme)
    (setq theme
          (cond
           ;; 1. Check Background Lightness (Threshold 0.5)
           ((> bg-light 0.5)
            (cond
             ((< sat 0.1)  'ef-light)
             ((< hue 0.10) 'ef-summer)
             ((< hue 0.25) 'ef-spring)
             ((< hue 0.55) 'ef-cyprus)
             ((< hue 0.75) 'ef-frost)
             ((< hue 0.90) 'ef-kassio)
             (t 'ef-summer)))
           ;; 2. Dark Themes (Background is dark)
           (t
            (cond
             ((< sat 0.1)  'ef-dark)
             ((< hue 0.10) 'ef-autumn)
             ((< hue 0.20) 'ef-symbiosis)
             ((< hue 0.45) 'ef-bio)
             ((< hue 0.55) 'ef-maris-dark)
             ((< hue 0.75) 'ef-winter)
             ((< hue 0.90) 'ef-cherie)
             (t 'ef-autumn)))))
    (ef-themes-load-theme theme)))

(hesam/pick-ef-theme-by-hsl "{{colors.primary.default.hsl}}" "{{colors.surface.default.hsl}}")
