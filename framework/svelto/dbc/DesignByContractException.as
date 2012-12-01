package svelto.dbc
{
	/// <summary>
	/// Exception raised when a contract is broken.
	/// Catch this exception type if you wish to differentiate between 
	/// any DesignByContract exception and other runtime exceptions.
	///  
	/// </summary>
	public class DesignByContractException extends Error
	{
		public function DesignByContractException(message:String) { super(message);  }
	}
}