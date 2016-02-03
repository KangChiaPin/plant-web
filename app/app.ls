$ <- -> it jQuery
<-! $ document .ready

########################################################
# routing
#
$ "#{window.location.href - /http:\/\/.*?\//}" .add-class \active

$ \a .click ->
  $ \.page .remove-class \active
  $ "#{$ @ .attr \href}" .add-class \active

########################################################
# page-01a
#
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
