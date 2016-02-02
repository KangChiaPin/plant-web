
# routing
$ \a .click ->
  $ \.page .remove-class \active
  $ "#{$ @ .attr \href}" .add-class \active

$ \.nav .click -> $ \.menu .toggle!
$ '.menu a' .click -> $ \.menu .hide!

$ '.circle.small' .click -> $ \.detail .add-class \open
