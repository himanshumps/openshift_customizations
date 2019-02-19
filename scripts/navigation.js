window.OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.splice(
	OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.length,
	0, {
		id: 'openshiftplusplus',
		label: 'Openshift++',
		subCategories: [{
				id: 'platformadmin',
				label: 'Platform Admin',
				tags: ['go'],
				icon: 'fa fa-mobile'
			},
			{
				id: 'platformdeveloper',
				label: 'Platform Developer',
				tags: ['go'],
				icon: 'fa fa-database'
			}
		]
	}
);
