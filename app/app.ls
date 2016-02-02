
# routing
$ \a .click ->
  $ \.page .remove-class \active
  $ "#{$ @ .attr \href}" .add-class \active

# page-01
$ \.nav .click -> $ \.menu .toggle!

$ '.menu a' .click -> $ \.menu .hide!

$ '.circle.small' .click -> $ \.detail .add-class \open

# page-01-1
test-data =
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrr'
  * category: \sea title: 'so hot hot rrrjwefkljfewklfewjklefwjkeflwjfwekljfkelewfjklfewjklfewjkeflw'
  ...

item = d3.select ".list" .select-all \.item
         .data test-data .enter!
         .append \div .classed {+item}
item.append \div .classed {+cat}
    .text -> it.category
item.append \div .classed {+image}
item.append \div .classed \item-title, true
    .text -> it.title

# vi:et:ft=ls:nowrap:sw=2:ts=2
