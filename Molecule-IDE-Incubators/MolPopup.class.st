"
class for the popup on a component
"
Class {
	#name : #MolPopup,
	#superclass : #Object,
	#instVars : [
		'popup'
	],
	#category : #'Molecule-IDE-Incubators-Popup'
}

{ #category : #'accessing structure variables' }
MolPopup >> popup: aPopup title: aComponent [ 

"define component popup"

| labelRequired labelComponentType labelUsedComponentServices labelConsumedComponentEvents labelUsedComponentParameters labelOffered labelProvidedComponentServices labelProvidedComponentParameters labelProducedComponentEvents molContract label|

	molContract := MolContract new.
	
	labelComponentType := RSLabel new  model: 'Type : ', (molContract type: aComponent) asString.
	label := RSLabel new  model: ' '.
	labelRequired := RSLabel new  model: 'Required'.
	labelUsedComponentServices := RSLabel new model: 'Used Services : ', (molContract usedServices: aComponent) asString.
	labelConsumedComponentEvents := RSLabel new model: 'Consumed Events : ', (molContract consumedEvents: aComponent) asString.
	labelUsedComponentParameters := RSLabel new  model: 'Used Parameters : ', (molContract usedParameters: aComponent) asString.
	labelOffered := RSLabel new  model: 'Offered'.
	labelProvidedComponentServices := RSLabel new model: 'Provided Services : ', (molContract providedServices: aComponent) asString.
	labelProvidedComponentParameters := RSLabel new  model: 'Provided Parameters : ',(molContract providedParameters: aComponent) asString.
	labelProducedComponentEvents := RSLabel new model: 'Produced Events : ' , (molContract producedEvents: aComponent) asString.
	
	popup := aPopup.
	popup shapeBuilder: [
	|  composite lb |
		composite := RSComposite new.
		lb := RSLegend new.
		lb container: composite.
		lb title: aComponent.
		{labelComponentType. label. labelRequired.
		 labelUsedComponentServices.labelConsumedComponentEvents.labelUsedComponentParameters. 
		label.
		labelOffered. labelProvidedComponentServices. labelProducedComponentEvents.
		labelProvidedComponentParameters} do: [ :selector | lb text: selector model ].
		lb build.
		composite
			color: Color white;
			withBorder;
			padding: 5.
	].
]

{ #category : #'as yet unclassified' }
MolPopup >> popup: aPopup title: aComponent items: items [
	"create a popup with a lengend inside"
	popup := aPopup.
	popup shapeBuilder: [
	|  composite lb |
		composite := RSComposite new.
		lb := RSLegend new.
		lb container: composite.
		lb title: aComponent.
		items do: [ :selector | lb text: selector model ].
		lb build.
		composite
			color: Color white;
			withBorder;
			padding: 5.
	].
]
