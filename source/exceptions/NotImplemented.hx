package exceptions;

class NotImplemented extends Exception
{
    public function new(obj:Dynamic, methodName:String)
    {
        var className = Type.getClassName(Type.getClass(obj));

        super(className + " does not implement " + methodName + ".");
    }
}
