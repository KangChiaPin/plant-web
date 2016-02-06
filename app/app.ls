$ <- -> it jQuery
<-! $ document .ready

########################################################
## navigator

navigator =
  init-route: init-route
  jump-to: jump-to
  back: back
  router-stack: []
  index: \#page-01a

!function init-route
  id = window.location.href - /http:\/\/.*?\//; id = navigator.index if id is ''
  navigator.router-stack.push id
  render-page id; render-nav id

!function jump-to id
  navigator.router-stack.push id
  render-page id; render-nav id

!function back
  navigator.router-stack.pop!
  id = navigator.router-stack[navigator.router-stack.length - 1]
  window.location.href = window.location.origin + "/#id"
  render-page id; render-nav id

!function render-page id
  $ \.page .remove-class \active
  $ "#id" .add-class \active

!function render-nav id
  if navigator.router-stack.length > 1 then $ '#nav .back' .show! else $ '#nav .back' .hide!
  $ '#nav .title' .text ($ "#id" .data \title)

navigator.init-route!

$ '.page a' .click ->
  navigator.jump-to "#{$ @ .attr \href}"

$ '#menu a' .click ->
  navigator.router-stack = []
  navigator.jump-to "#{$ @ .attr \href}"

$ \.btn.back .on \click, !->
  navigator.back!

$ \.sw-icon .click ->
  navigator.jump-to \#page-02a

########################################################
## nav block

$ \.page .on \scroll, ->
  if $ this .scroll-top! > 0
    $ \#nav .css \box-shadow, '4px 4px 5px grey'
  else => $ \#nav .css \box-shadow, 'none'

########################################################
## page-01a <<< calculate orbit

orbit-test-data = [1,2,3,4,5,6]
size = orbit-test-data.length # arr size

# parameter
$big-radius = 10 # vh
$hidden-part = 3 # vh
$small-radius = 3 # vh
$speed = 0.04
$dis = $big-radius + $small-radius + 3 # vh

d3.select \#page-01a .append \div .classed {+big, +circle}
  .style \bottom, "#{-$hidden-part}vh"
  .style \width, "#{2*$big-radius}vh"
  .style \height, "#{2*$big-radius}vh"
  .style \border-radius, "#{$big-radius}vh"

d3.select \#page-01a .select-all \.small
  .data orbit-test-data .enter!
  .append \div .classed {+small, +circle}
  .style \bottom, "#{$big-radius - $small-radius - $hidden-part}vh"
  .style \margin-left, "#{-$small-radius}vh"
  .style \width, "#{2*$small-radius}vh"
  .style \height, "#{2*$small-radius}vh"
  .style \border-radius, "#{$big-radius}vh"

start = Date.now!
d3.timer !->
  a = (Date.now! - start) * $speed
  d3.select-all \.small.circle
    .style \transform, (d, i)->
      "rotate(#{(360/size*i+a)/180*Math.PI}deg)
      translate(#{$dis*Math.cos((360/size*i+a)/180*Math.PI)}vh, #{$dis*Math.sin((360/size*i+a)/180*Math.PI)}vh)"
, 0

## page-01a

$ '#nav .btn.menu' .click -> $ \#menu .toggle!

$ '#menu a' .click -> $ \#menu .hide!

$ '.circle.small' .click -> $ \.detail .add-class \open

########################################################
## page-01b

test-data =
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrrjwefkljfewklfewjklefwjkeflwjfwekljfkelewfjklfewjklfewjkeflw'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrrjwefkljfewklfewjklefwjkeflwjfwekljfkelewfjklfewjklfewjkeflw'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrrjwefkljfewklfewjklefwjkeflwjfwekljfkelewfjklfewjklfewjkeflw'
  ...

[left, right] =
  * test-data.slice 0, (test-data.length / 2)
  * test-data.slice (test-data.length / 2)

for col in [\left, \right]
  item = d3.select ".col.#col" .select-all \.item
      .data (eval "#col") .enter!
      .append \div .classed {+item}
  item.append \a .attr \href, \#page-01c
      .on \click, -> navigator.jump-to "#{$ @ .attr \href}"
  item.append \div .classed {+cat}
      .text -> it.category
  item.append \div .classed {+image}
  item.append \div .classed \item-title, true
      .text -> it.title

########################################################
## page-01c

########################################################
## page-02


# vi:et:ft=ls:nowrap:sw=2:ts=2
