window.OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.splice(
	OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.length-1,
	0, {
		id: 'openshiftplusplus',
		label: 'Openshift Plus Plus',
		subCategories: [{
				id: 'platformadmin',
				label: 'Platform Admin',
				tags: ['go','golang'],
				icon: 'icon-go-gopher'
			},
			{
				id: 'platformdeveloper',
				label: 'Platform Developer',
				tags: ['go','golang'],
				icon: 'icon-go-gopher'
			}
		]
	}
);

angular
  .module('aboutPageExtension1', ['openshiftConsole'])
  .config(function($routeProvider) {
    $routeProvider
      .when('/test', {
        templateUrl: 'https://www.google.com',
        controller: 'AboutController'
      });
    }
  );

hawtioPluginLoader.addModule('aboutPageExtension1');
