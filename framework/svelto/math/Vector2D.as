package svelto.math
{
	import flash.geom.Point;

	//copied from somewhere and improved

	public class Vector2D
	{
		static public var UP:Vector2D = new Vector2D(0, -1);
		static public var DN:Vector2D = new Vector2D(0, 1);
		static public var LT:Vector2D = new Vector2D(-1, 0);
		static public var RT:Vector2D = new Vector2D(1, 0);
		
		public var x:Number;
		public var y:Number;

		public function Vector2D(_opt_px:Number = 0, _opt_py:Number = 0) 
		{
			x = _opt_px;
			y = _opt_py;
		}

		public function setTo(px:Number, py:Number):void 
		{
			x = px;
			y = py;
		}

		public function copy(v:Vector2D):void 
		{
			x = v.x;
			y = v.y;
		}


		public function dot(v:Vector2D):Number 
		{
			return x * v.x + y * v.y;
		}

		public function cross(v:Vector2D):Number 
		{
			return x * v.y - y * v.x;
		}

		public function plus(v:Vector2D):Vector2D 
		{
			return new Vector2D(x + v.x, y + v.y);
		}

		public function plusEquals(v:Vector2D):Vector2D 
		{
			x += v.x;
			y += v.y;
			return this;
		}

		public function minus(v:Vector2D):Vector2D 
		{
			return new Vector2D(x - v.x, y - v.y);
		}

		public function minusEquals(v:Vector2D):Vector2D 
		{
			x -= v.x;
			y -= v.y;
			return this;
		}

		public function times(s:Number):Vector2D 
		{
			return new Vector2D(x * s, y * s);
		}
		
		public function timesEqual(s:Number):Vector2D 
		{
			x *= s;
			y *= s;
			return this;
		}

		public function multEquals(v:Vector2D):Vector2D 
		{
			x *= v.x;
			y *= v.y;
			return this;
		}

		public function mult(v:Vector2D):Vector2D 
		{
			return new Vector2D(x * v.x, y * v.y);
		}

		public function magnitude():Number 
		{
			return Math.sqrt(x * x + y * y);
		}

		public function distance(v:Vector2D):Number 
		{
			var delta:Vector2D = this.minus(v);
			return delta.magnitude();
		}
		
		public function zero():void 
		{
			x = 0;
			y = 0;
		}

		public function normalize():Vector2D 
		{
			 var m:Number = magnitude();
			 if (m == 0) m = 0.0001;
			 return times(1 / m);
		}
		
		public function normalizeEquals():Vector2D 
		{
			 var m:Number = magnitude();
			 if (m == 0) m = 0.0001;
			 return timesEqual(1 / m);
		}

		public function rotate(r:Vector2D):Vector2D 
		{
			return new Vector2D(x*r.x - y*r.y, x*r.y + y*r.x);
		}
		
		public function fromRotation(rad:Number):void
		{
			x = Math.cos(rad);
			y = Math.sin(rad);
		}
		
		public function polarAngle():Number
		{
			return Math.atan2(y, x) * 180 / Math.PI;
		}
		
		public function toPoint(origin:Point=null):Point
		{
			if (!origin)
				origin = new Point(0, 0);
	 
			return new Point(origin.x + x, origin.y + y);
		}
		
		static public function inverseTransform(vector:Vector2D, forward:Vector2D):Vector2D
		{
			var i:Vector2D = forward;
			var j:Vector2D = forward.perpendicular();
			
			return new Vector2D(vector.x * i.x + vector.y * i.y, vector.x * j.x + vector.y * j.y);
		}
		
		static public function transform(vector:Vector2D, forward:Vector2D):Vector2D
		{
			var i:Vector2D = forward;
			var j:Vector2D = forward.perpendicular();
			
			vector.setTo(vector.x * i.x + vector.y * j.x, vector.x * i.y + vector.y * j.y);
			
			return vector;
		}
		
		public function oppositeSelf():Vector2D 
		{
			x = -x;
			y = -y;
			
			return this;
		}

		public function opposite():Vector2D 
		{
			return new Vector2D(-x, -y);
		}
		
		public function perpendicular():Vector2D
		{
			return new Vector2D(y , -x);
		}
		
		public function toAngleDeg():Number 
		{
			return (toAngleRad() * 180.0) / (Math.PI);	
		}
		
		public function toAngleRad():Number 
		{
			return Math.atan2(y, x);	
		}
		
		public function toString():String 
		{
			return (x + " : " + y);
		}
	}
}
