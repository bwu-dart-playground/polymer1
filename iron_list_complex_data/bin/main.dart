class BaseClass
{
    static final String myStaticValue = 'hello';
    String get myStaticValue2 => myStaticValue; // names need to differ in some way
}

class MyClass<T extends BaseClass> {
  MyClass() {
    print(T);
  }
}

class SubClass extends BaseClass {

}

void main() {
  new MyClass<SubClass>();
}

