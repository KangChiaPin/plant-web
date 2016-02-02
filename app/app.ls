
# routing
$ \a .click ->
  $ \.page .remove-class \active
  $ "#{$ @ .attr \href}" .add-class \active

