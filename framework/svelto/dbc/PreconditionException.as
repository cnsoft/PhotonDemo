package svelto.dbc
{
/// <summary>
/// Exception raised when a precondition fails.
/// </summary>
	public class PreconditionException extends DesignByContractException
	{
		public function PreconditionException(message:String)
		{
			super(message);
		}
	}

}