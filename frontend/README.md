# javascript

## sync and async

https://nolanlawson.com/2024/07/28/is-it-okay-to-make-connectedcallback-async/

# modern web

https://developers.home-assistant.io/blog/2019/05/22/internet-of-things-and-the-modern-web?_highlight=moder

https://justinfagnani.com/2015/12/21/real-mixins-with-javascript-classes/

## web components

https://naver.github.io/egjs/

https://material-web.dev/about/quick-start/

https://github.com/lit/lit

https://lit.dev/docs/

https://developer.mozilla.org/en-US/docs/Web/CSS/var

### timers

https://github.com/abhijeet-shelhalkar/my-timer-lit/tree/main

### range and sliders

https://www.smashingmagazine.com/2021/12/create-custom-range-input-consistent-browsers/

https://github.com/material-components/material-web/blob/main/docs/components/slider.md

https://blog.logrocket.com/creating-custom-css-range-slider-javascript-upgrades/#adding-javascript-style-range-slider-progress

we want to transform a text input into a slider :

![image](https://github.com/user-attachments/assets/b596ae64-51d2-4ccd-aada-db41ff28fad4)


![image](https://github.com/user-attachments/assets/ab32cf70-265d-4fbb-8c2d-09459fecf24f)


it is possible to use slider (range) within json-editor : https://github.com/jdorn/json-editor/issues/4

this gave me the intuition : https://lit.dev/tutorials/svg-templates/

to create a custom theme is necessary if you want to add a scale, the wiki is now OK but previously it was wrong

- https://github.com/json-editor/json-editor/issues/763
- https://github.com/json-editor/json-editor/issues/643

https://github.com/json-editor/json-editor/wiki#theme-srcthemejs

## custom elements

https://stackoverflow.com/questions/74517249/how-to-create-custom-input-slider

https://dev.to/zippcodder/a-quick-guide-to-custom-html-elements-5f3b

https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements

## circular slider in typescript with lit

https://github.com/thomasloven/round-slider/blob/master/src/round-slider.ts

## circular sliders using `<input type="range" />`

https://dev.to/madsstoumann/accessible-circular-sliders-11p

https://codepen.io/stoumann/pen/mdrEEMw

https://browser.style/ui/range-circular/

## another circular slider more simple

https://m.youtube.com/watch?v=Wq77gh1D3GY

https://github.com/SnippetsDevelop/snippetsdevelop.github.io/blob/master/codes/Circular-Slider.html

## another circular slider with nearly only css

https://codepen.io/long-lazuli/pen/NPEPyM

# emoncms menu v3

in theme.php

line 35 :
- 2.3.2 : `<link href="<?php echo $path; ?>Lib/bootstrap/css/bootstrap.css" rel="stylesheet">`
- 3.0.0 : `<link href="<?php echo $path; ?>Lib/bootstrap/3.0.0/css/bootstrap.css" rel="stylesheet">`
- tested with version 3.3.4, 3.3.5, 3.3.7, 4.0.0, 4.2.0 : not working

5.1.0 : `<link href="<?php echo $path; ?>Lib/bootstrap/bootstrap.css" rel="stylesheet">`

line 104 or 105 :
- 2.3.2 :   `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/js/bootstrap.js"></script>`
- 3.0.0 :   `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/3.0.0/js/bootstrap.js"></script>`

5.1.0 : `<script type="text/javascript" src="<?php echo $path; ?>Lib/bootstrap/bootstrap.js"></script>`


line 40 or 41 : 
- `<script type="text/javascript" src="<?php echo $path; ?>Lib/jquery-1.11.3.min.js"></script>`
- `<script type="text/javascript" src="<?php echo $path; ?>Lib/jquery-3.6.0.js"></script>`

jquery 1.11.3 has security issues
https://snyk.io/test/npm/jquery/1.11.3

it seems bootstrap 2.3.2 is OK
