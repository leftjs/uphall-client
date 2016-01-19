angular.module('tmsApp')
.controller('LoginCtrl', ['$scope', '$location', '$http', 'tmsUtil', ($scope, $location, $http, tmsUtil) ->
    $scope.userEntity = {
      username: ''
      password: ''
      rememberMe: false
    }
    $scope.doLogin = ->
      $http.post("#{Tms.apiAddress}/api/user/login", {
        username: $scope.userEntity.username
        password: $scope.userEntity.password
      })
      .then((res)->
        if $scope.userEntity.rememberMe
          localStorage.setItem('username', $scope.userEntity.username)
        else
          localStorage.removeItem('username')
        token = res.data.token
        $http.defaults.headers.common['x-token'] = token
        localStorage.setItem('x-token', token)
        $location.path('/').replace()
      , tmsUtil.processHttpError)
    init = ->
      username = localStorage.getItem('username')
      if username
        $scope.userEntity.rememberMe = true
        $scope.userEntity.username = username
    init()
  ])