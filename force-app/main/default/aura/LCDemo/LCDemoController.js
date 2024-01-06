({
	handler : function(component, event, helper) {
		component.set("v.message",event.getSource().get("v.label"))
	},
    
    doInit : function(component, event, helper) {
		component.set("v.message","Hello World! This message is from handler.")
        component.set("v.Object", {'name' : 'shivang', 'age' : '28'})
	},
})