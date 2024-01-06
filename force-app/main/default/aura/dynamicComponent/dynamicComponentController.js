({

    createButtonDynamically : function(component, event, helper) {
    /* $A.createComponent(String type, Object attributes, function callback) */
        //Creating button dynamically
        
        var db = component.find('newtag');
        /* $A.createComponent (
        'ui:button',
        {
        'label':'New Button'+db.get('v.body').length,
        'press': component.getReference('c.showPressedButtonLabel')
        },
        
        function(dynamicButton, status, errorMessage)
        
        {
        
        //Add the new button to the body array
        
        if (status === 'SUCCESS') {
        
        var bdy=db.get('v.body');
        
        bdy.push(dynamicButton);
        
        db.set('v.body',bdy);
        
        }
        
        else if (status === 'INCOMPLETE') {
        
        console.log('No response from the server!')
        
        }
        
        else if (status === 'ERROR') {
        
        console.log('Error: ' +errorMessage);
        
        }
        
        }
        
        ); */

        /* $A.createComponent(
            "lightning:input",
            {
                "label": "Enter a value",
                "name": "inputField",
                "value": component.getReference("v.inputValue"), // Assuming you have a bound attribute named "v.inputValue"
                "aura:id": "dynamicInput"
            },
            function(newInput){
                // Add the new input field to the body of the component
                var body = component.get("v.body");
                body.push(newInput);
                component.set("v.body", body);
            }
        ) */

        /* $A.createComponent(
            "lightning:tab",
            {
                "label": "Tab Label",
                "name": "tab1",
                "id": "dynamicTab",
                "onactive": component.getReference("c.handleTabActive") // Assuming you have a controller method named "handleTabActive"
            },
            function(newTab){
                // Add the new tab to the body of the component
                var body = component.get("v.body");
                body.push(newTab);
                component.set("v.body", body);
            }
        ); */
        $A.createComponents([
            ["lightning:card",{
                        "title" : "Dynamic Components"
                    }],
                    ["lightning:icon",{
                        "iconName" : "utility:success",
                        "alternativeText": "Icon that represents a successful step",
                        "variant": "success",
                        "class": "slds-m-around_small"
                    }]
            ],
            function(components, status, errorMessages){
                if (status === "SUCCESS") {
                    var card = components[0];
                    var icon = components[1];
                    // set lightning:icon as the body of lightning:card
                    card.set("v.body", icon);
                    cmp.set("v.body", card);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error message: " + errorMessages[0].message);
                }
            }
        );
    
    },
    
    removeButtonDynamically : function(component, event, helper){
    
    component.find('newtag').set('v.body',[]);
    
    //Destroying the component dynamically.
    
    },
    
    showPressedButtonLabel : function(component, event, helper){
    
    alert('You pressed:'+event.getSource().get('v.label'));
    
    }
    
})