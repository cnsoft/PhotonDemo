package svelto.efw.plugins.mouse 
{
	public interface IDraggableComponent extends IMouseComponent
	{
		function drag(): void;
		function stopDrag(): void;
	}
}