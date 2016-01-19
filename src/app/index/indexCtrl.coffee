angular.module('tmsApp')
.controller('IndexCtrl', ['$scope', '$location', '$http', 'tmsUtil', ($scope, $location, $http, tmsUtil) ->
    # scope����
    $scope.task = {
      taskName: ''
    }
    $scope.taskList = []

    init = ->
      console.log(2)
      $http.get("#{Tms.apiAddress}/api/task")
      .then((res) ->
        tasks = res.data
        $scope.taskList = tasks
      , tmsUtil.processHttpError)

    $scope.exit =  ->
      $http.post("#{Tms.apiAddress}/api/user/logout")
      .then(->
        alert('Logout succeed.')
        $location.path('/login')
      , tmsUtil.processHttpError)

    $scope.changeTaskStatus = (task) ->
      task.status = if task.checked then 'Finish' else 'InProgress'
    $scope.deleteTask = (task, index) ->
      task.deleted = trues
      $http.put("#{Tms.apiAddress}/api/task", task)
      .then(->
        $scope.taskList.splice(index, 1)
      , tmsUtil.processHttpError)
    $scope.editTask = (task) ->
      task.isEditing = true
      task.tempTaskName = task.taskName
    $scope.cancelEditTask = (task) ->
      task.isEditing = false
    $scope.saveTask = (task) ->
      oldTaskName = task.taskName
      task.taskName = task.tempTaskName
      $http.put("#{Tms.apiAddress}/api/task", task)
      .then((res) ->
        task.isEditing = false
      , (res) ->
        task.taskName = oldTaskName
        tmsUtil.processHttpError(res)
      )
    # UI����
    $scope.addTask = ->
      task = angular.copy($scope.task)
      $http.post("#{Tms.apiAddress}/api/task", {taskName: task.taskName })
      .then((res) ->
        newTask = res.data
        task._id = newTask._id
        task.deleted = newTask.deleted
        $scope.taskList.push(task)
        $scope.task.taskName = ''
      , tmsUtil.processHttpError)

    init()
  ])