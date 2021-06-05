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
	"Component info popup"
	| labelRequired labelComponentType labelUsedComponentServices labelConsumedComponentEvents labelUsedComponentParameters labelOffered labelProvidedComponentServices labelProvidedComponentParameters labelProducedComponentEvents label|
	
	labelComponentType := RSLabel new  model: 'Type : ', (aComponent componentType ifNil:['--']) asString.
	label := RSLabel new  model: ' '.
	labelRequired := RSLabel new  model: 'Required'.
	labelUsedComponentServices := RSLabel new model: 'Used Services : ', ((MolUtils usedComponentServices: aComponent) ifEmpty:['--']) asString.
	labelConsumedComponentEvents := RSLabel new model: 'Consumed Events : ', ((MolUtils consumedComponentEvents: aComponent) ifEmpty:['--']) asString.
	labelUsedComponentParameters := RSLabel new  model: 'Used Parameters : ', ((MolUtils usedComponentParameters: aComponent) ifEmpty:['--']) asString.
	labelOffered := RSLabel new  model: 'Offered'.
	labelProvidedComponentServices := RSLabel new model: 'Provided Services : ', ((MolUtils providedComponentServices: aComponent) ifEmpty:['--']) asString.
	labelProvidedComponentParameters := RSLabel new  model: 'Provided Parameters : ',((MolUtils providedComponentParameters: aComponent) ifEmpty:['--']) asString.
	labelProducedComponentEvents := RSLabel new model: 'Produced Events : ' , ((MolUtils producedComponentEvents: aComponent) ifEmpty:['--']) asString.
	
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

{ #category : #'accessing structure variables' }
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
