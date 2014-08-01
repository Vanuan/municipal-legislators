var app = angular.module('OpenMunicData', []);

app.
    config(['$routeProvider', function($routeProvider) {
        $routeProvider.
            when('/', {
                redirectTo: function () {
                    return "/people";
                }
            }).
            when('/people', {templateUrl: 'templates/people.html', controller: PeopleCtrl})
    }]);

function PeopleCtrl($scope, PeopleService) {
    PeopleService.getPeople().then(function onPeople(people) {
        $scope.people = people;
    });
}

app.factory('PeopleService', function($q, $rootScope) {
    return {
        getPeople: function getPeople() {
            var deferred = $q.defer();
            $rootScope.$broadcast('Loading');
            $.get("/people.json", function cb(people) {
                $rootScope.$apply(function () {deferred.resolve(people)});
            }).fail(function onError(error) {
                $rootScope.$apply(function () {deferred.reject()});
                $rootScope.$broadcast('APIError', error);
            });
            return deferred.promise;
        }
    };
});
