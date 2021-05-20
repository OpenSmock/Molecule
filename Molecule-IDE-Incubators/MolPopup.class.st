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

| labelRequired labelComponentType labelUsedComponentServices labelConsumedComponentEvents labelUsedComponentParameters labelOffered labelProvidedComponentServices labelProvidedComponentParameters labelProducedComponentEvents molContract |

	molContract := MolContract new.
	
	labelComponentType := RSLabel new  model: 'ComponentType : ', (molContract type: aComponent) asString.
	labelRequired := RSLabel new  model: 'REQUIRED'.
	labelUsedComponentServices := RSLabel new model: 'UsedServices : ', (molContract usedServices: aComponent) asString.
	labelConsumedComponentEvents := RSLabel new model: 'ConsumedEvents : ', (molContract consumedEvents: aComponent) asString.
	labelUsedComponentParameters := RSLabel new  model: 'UsedParameters : ', (molContract usedParameters: aComponent) asString.
	labelOffered := RSLabel new  model: 'OFFERED'.
	labelProvidedComponentServices := RSLabel new model: 'ProvidedServices : ', (molContract providedServices: aComponent) asString.
	labelProvidedComponentParameters := RSLabel new  model: 'ProvidedParameters : ',(molContract providedParameters: aComponent) asString.
	labelProducedComponentEvents := RSLabel new model: 'ProducedEvents : ' , (molContract producedEvents: aComponent) asString.
	
	popup := aPopup.
	popup shapeBuilder: [
	|  composite lb |
		composite := RSComposite new.
		lb := RSLegend new.
		lb container: composite.
		lb title: aComponent.
		{labelComponentType. labelRequired.
		 labelUsedComponentServices.labelConsumedComponentEvents.labelUsedComponentParameters. 
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
