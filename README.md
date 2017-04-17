This project demonstrates how to deploy Visualforce as a dummy container
for a Lightning component, for [use cases][1] as of Spring '17 that still
require Visualforce to be used for custom UI development
in Lightning Experience.

[1]: https://trailhead.salesforce.com/modules/lex_javascript_button_migration/units/javascript_button_alternatives

## Installation

After deploying this package to your org, all you need to do is create a
**New Custom Button or Link** on the Lead object, configured as follows.

| Field | Value |
| ----- | ----- |
| Label | Change Owner |
| Name | ChangeOwner |
| Display Type | List Button, with "Display Checkboxes" checked |
| Behavior | Display in existing window without sidebar or header |
| Content Source | Visualforce Page |
| Content | LeadMassAssignSlds |

Then, edit the Leads List View search layout, and remove the standard
**Change Owner** button but add your newly created custom button.