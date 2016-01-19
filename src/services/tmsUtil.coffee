angular.module('tmsApp')
.factory('tmsUtil', [() ->
    processHttpError = (res) ->
      data = res.data
      if data.message
        alert(data.message)
    return {
      processHttpError: processHttpError
    }
  ])