angular.module('tmsApp')
.controller('RegisterCtrl', ['$scope', '$http', '$location', 'tmsUtil', ($scope, $http, $location, tmsUtil) ->
    $scope.userEntity = {
      username: ''
      password: ''
      password2: ''
    }
    $scope.doRegister = ->
      return alert('两次密码不一致') if $scope.userEntity.password isnt $scope.userEntity.password2
      $http.post("#{Tms.apiAddress}/api/user/register", {
        username: $scope.userEntity.username
        password: $scope.userEntity.password2
      }).then((res) ->
        alert('注册成功！')
        $location.path('/login')
      , tmsUtil.processHttpError)
  ])