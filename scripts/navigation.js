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

window.OPENSHIFT_CONSTANTS.SAAS_OFFERINGS = [{
  title: "Openshift ++",                         // The text label
  icon: "fa fa-snowflake-o",                    // The icon you want to appear
  url: "http://example.com/dashboard",        // Where to go when this item is clicked
  description: "The one shop for creating the E2E microservices application"  // Short description
}];
