// Add a Featured category as the first category tab.
window.OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.unshift({
  // Required. Must be unique.
  id: "featured",
  // Required
  label: "Featured",
  subCategories: [
    {
      // Required. Must be unique.
      id: "go",
      // Required.
      label: "Go",
      // Optional. If specified, defines a unique icon for this item.
      icon: "icon-go-gopher",
      // Required. Items matching any tag will appear in this subcategory.
      tags: [
        "go",
        "golang"
      ]
    },
    {
      // Required. Must be unique.
      id: "jenkins",
      // Required.
      label: "Jenkins",
      // Optional. If specified, defines a unique icon for this item.
      icon: "icon-jenkins",
      // Required. Items matching any tag will appear in this subcategory.
      tags: [
        "jenkins"
      ]
    }
  ]
});
