(function(){
var app = angular.module('OpenMunicData', ['ngResource']);

app.
    config(['$routeProvider', function($routeProvider) {
        $routeProvider.
            when('/', {
                redirectTo: function () {
                    return "/people";
                }
            }).
            when('/people', {templateUrl: 'templates/people.html', controller: 'PeopleCtrl'})
    }]);

app.factory('PeopleService', ['$resource', function($resource) {
      return $resource('people.json', {}, {
        query: {method:'GET', params:{}, isArray:true}
      });
}]);

app.controller('PeopleCtrl', ['$scope', 'PeopleService', function($scope, PeopleService) {
    PeopleService.query(function (people) {
        $scope.people = people;
    });
}]);


})();
