$ <- -> it jQuery
<-! $ document .ready

########################################################
# routing

$ "#{window.location.href - /http:\/\/.*?\//}" .add-class \active

$ \a .click ->
  $ \.page .remove-class \active
  $ "#{$ @ .attr \href}" .add-class \active

########################################################
# nav

$ \.page .on \scroll, ->
  if $ this .scroll-top! > 0
    $ \#nav .css \box-shadow, '4px 4px 5px grey'
  else => $ \#nav .css \box-shadow, 'none'

########################################################
# page-01a <<< calculate orbit

orbit-test-data = [1,2,3,4,5,6]

$big-radius = 10 # vh
$hidden-part = 3 # vh
$small-radius = 3 # vh
$speed = 5 # s
$size = orbit-test-data.length # arr size
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
  a = (Date.now! - start) * 0.04
  transform = (d, i)->
    "rotate(#{(360/$size*i+a)/180*Math.PI}deg)
    translate(#{$dis*Math.cos((360/$size*i+a)/180*Math.PI)}vh, #{$dis*Math.sin((360/$size*i+a)/180*Math.PI)}vh)"
  d3.select-all \.small.circle .style \transform, transform
, 0


# page-01a

$ \#nav .click -> $ \#menu .toggle!

$ '#menu a' .click -> $ \#menu .hide!

$ '.circle.small' .click -> $ \.detail .add-class \open

########################################################
# page-01b

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
      .on \click, ->
        $ \.page .remove-class \active
        $ "#{$ @ .attr \href}" .add-class \active
  item.append \div .classed {+cat}
      .text -> it.category
  item.append \div .classed {+image}
  item.append \div .classed \item-title, true
      .text -> it.title

########################################################
# page-01c

########################################################
# page-02

# vi:et:ft=ls:nowrap:sw=2:ts=2
