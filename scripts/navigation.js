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
  .module('aboutPageExtension', ['openshiftConsole'])
  .config(function($routeProvider) {
    $routeProvider
      .when('/test', {
        templateUrl: 'https://himanshumps.github.io/openshift_customizations/scripts/index.html',
        controller: 'AboutController'
      });
    }
  );

hawtioPluginLoader.addModule('aboutPageExtension');
