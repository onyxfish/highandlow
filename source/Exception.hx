package;

import haxe.CallStack;

/**
  * Base class for all exceptions.
  * Also a bit of a hack to print them since the global error
  * handler seems busted.
  */
class Exception
{
    var _message:String;
    var _callStack:Array<StackItem>;

    public function new(message:String)
    {
        _message = Type.getClassName(Type.getClass(this)) + ": " + message;

        _callStack = CallStack.callStack();
        _callStack.reverse();

        print();
    }

    public function print()
    {
        trace(CallStack.toString(_callStack));
        trace(_message);
    }
}
