program BaseConversionPro;

uses
  Forms,
  BaseConvereterU in 'BaseConvereterU.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
