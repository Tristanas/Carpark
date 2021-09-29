page 51000 "Hello World"
{
    layout
    {
        area(Content)
        {
            group("Hello World!")
            {
                field(Name; name)
                {
                    Caption = 'What is your name?';
                }
            }
        }
    }

    var
        name: Text;
}