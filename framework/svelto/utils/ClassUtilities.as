package svelto.utils 
{
	import org.as3commons.lang.ClassUtils;
	
	public class ClassUtilities
	{
		static public function getClass(object:Object):Class
		{
			if (object == null)
				return null;
				
			return object["constructor"]; 
		}
		
		static public function isAssignableFrom(classFrom:Class, objToCheck:Object):Boolean
		{
			return ClassUtils.isAssignableFrom(classFrom, getClass(objToCheck));
		}
	}
}