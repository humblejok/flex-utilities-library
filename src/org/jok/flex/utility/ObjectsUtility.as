package org.jok.flex.utility
{
	import flash.utils.getDefinitionByName;
	
	import mx.collections.ArrayCollection;
	
	import org.jok.flex.utility.python.JSonPythonConverter;

	public class ObjectsUtility {

		/**
		 * Given an object and a chain of fields, it will return the value of that fields chain or null if one of the field in the chain does not exist. 
		 * @param obj The object
		 * @param fieldChain The chain of fields
		 * @return The value
		 * 
		 */
		public static function getObjectFieldValue(obj : Object,fieldChain : String) : Object {
			var argument : Object = obj;
			if (fieldChain==null || fieldChain=="") {
				return argument;
			}
			for each (var field : String in fieldChain.split(/\./)) {
				if (argument!=null) {
					try {
						argument = argument[field];
					} catch ( e : Error ) {
						break;
					}
				} else {
					break;
				}
			}
			return argument;
		}
		
		/**
		 * Given a collection of objects, a chain of fields and a value; it will return a collection of objects that have the chain of fields
		 * values that match the given value
		 * @param values The collection of objects
		 * @param fieldChain The chain of fields
		 * @param value The value to match
		 * @return The list of matching objects.
		 * 
		 */
		public static function getObjectsListWithMatch(values : ArrayCollection,fieldChain : String,value : Object) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			
			for each(var object : Object in values) {
				if (ObjectsUtility.getObjectFieldValue(object,fieldChain)==value) {
					result.addItem(object);
				}
			}
			
			return result;
		}
		
		/**
		 * Given a collection of objects and a chain of fields; it will return a collection of objects that contains 
		 * the fields values of all the objects from the initial collection
		 * @param values The collection of objects
		 * @param fieldChain The chain of fields
		 * @return The list of matching objects.
		 * 
		 */
		public static function getObjectsFieldValuesList(values : ArrayCollection,fieldChain : String) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			
			for each(var object : Object in values) {
				result.addItem(ObjectsUtility.getObjectFieldValue(object,fieldChain));
			}
			
			return result;
		}
		
		
		/**
		 * Extract the classpath of a full Method identifier. 
		 * @param completePath The complete path
		 * @return The classpath
		 * 
		 */
		public static function extractClassPathFromCompletePath(completePath : String) : String {
			return completePath.substr(0,completePath.lastIndexOf("."));
		}
		
		/**
		 * Extract the name of the method from a full Method identifier.
		 * @param completePath The complete path
		 * @return The method name
		 * 
		 */
		public static function extractMethodNameFromCompletePath(completePath : String) : String {
			return completePath.substr(completePath.lastIndexOf(".") + 1);
		}
		
		/**
		 * Given a full converting method path and an object, it will return the transformed object. 
		 * @param converterPath The complete path
		 * @param value The source object
		 * @return The transformed object
		 * 
		 */
		public static function applyConverter(converterPath : String, value : Object) : Object {
			var converterClass : Class = getDefinitionByName(ObjectsUtility.extractClassPathFromCompletePath(converterPath)) as Class;
			var i : Object = new converterClass();
			return i[ObjectsUtility.extractMethodNameFromCompletePath(converterPath)].call(converterClass,value);
		}
		
		public function castStringToBoolean(stringValue : String) : Boolean {
			if (stringValue.toString().toLocaleLowerCase()=="true") {
				return true;
			}
			return false;
		}
		
	}
}