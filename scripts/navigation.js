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
  title: "Dashboard",                         // The text label
  icon: "fa fa-dashboard",                    // The icon you want to appear
  url: "http://example.com/dashboard",        // Where to go when this item is clicked
  description: "Open application dashboard."  // Short description
}, {
  title: "System Status",
  icon: "fa fa-heartbeat",
  url: "http://example.com/status",
  description: "View system alerts and outages."
}, {
  title: "Manage Account",
  icon: "pficon pficon-user",
  url: "http://example.com/account",
  description: "Update email address or password."
}];
