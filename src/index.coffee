angular.module('tmsApp', ['ngRoute'])
.config(['$routeProvider', ($routeProvider) ->
    $routeProvider.when('/login', {
      templateUrl: '/app/login/index.html'
      controller: 'LoginCtrl'
    }).when('/register', {
      templateUrl: '/app/register/index.html'
      controller: 'RegisterCtrl'
    }).when('/', {
      templateUrl: '/app/index/index.html'
      controller: 'IndexCtrl'
    })
  ])
.run(['$location', '$http', '$route', ($location, $http, $route) ->
    token = localStorage.getItem('x-token')
    if token
      $http.post("#{Tms.apiAddress}/api/user/autologin", {token: token})
      .then((res) ->
        if res.data is true
          $http.defaults.headers.common['x-token'] = token
          localStorage.setItem('x-token', token)
          $route.reload()
        else
          $location.path('/login').replace()
      , ->
        $location.path('/login').replace()
      )
    else
      $location.path('/login').replace()
  ])