class Queue
  constructor: (@config)->
    @tasks = []
    @concurency = 0
    @_end = false
    @end_callback = null
    @end_promise = new Promise (resolve, reject)=>
      @end_callback = resolve
  push: (task)->
    console.log('push', task)
    @tasks.push(task)
    @run()
  run: ->
    if @concurency == 0 && @tasks.length == 0 && @_end
      @end_callback()
      
    if @concurency <= @config.concurency
      task = @tasks.pop()
      if task?
        @run_task(task)
        @run()
  end: ->
    @_end = true
    @run()
    @end_promise
  run_task: (task)->
    @concurency += 1
    console.log('run', task)
    @config.callback(task).then =>
      console.log('done', task)
      @concurency -= 1
      @run()
  
 module.exports = Queue

# (->
#   q = new Queue({
#     concurency: 5,
#     callback: ->
#       await new Promise (resolve, reject)->
#         setTimeout(resolve, 1000)
#   });
 #   q.push('a')
#   q.push('b')
#   q.push('c')
#   q.push('d')
#   q.push('e')
#   q.push('f')
#   console.log('before end')
#   await q.end()
#   console.log('END !')
# )()
