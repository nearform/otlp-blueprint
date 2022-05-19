// include  "root" {
//   path = find_in_parent_folders()
// }


include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}
