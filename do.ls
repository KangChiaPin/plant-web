# nop if process.title is \gulp # via gulp and thus express
Do '', console.log if process.title is \node # via command line
Do process.env.QUERY_STRING, console if process.env.HTTP_HOST? # via apache/lighttpd

!function Do query, outputer
  output query
  !function output err, data
    if typeof! outputer.send is \Function => outputer.send data # response object of express
    else if typeof! outputer.log is \Function => outputer.log "Content-type: text/html\n\n#data" # console object

module.exports = Do

# vi:et:nowrap:sw=2:ts=2
