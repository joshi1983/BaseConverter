unit BaseConvereterU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function HexToInt(str1: string): integer;
var
  c: integer;
  len: integer;
  ch: char;  // one character of the string
begin
     str1:=UpperCase(Str1);
     result:=0;
     len:=length(str1);
     for c:=len downto 1 do
     begin
          ch:=str1[c];
          if (ch<='F')and(ch>='A') then
             result:=result+(ord(ch)-55) shl ((len-c) shl 2)
             // same as result:=result+(ord(ch)-55) shl ((len-c)*16);
          else if (ch<='9')and(ch>'0') then
             result:=result+(ord(ch)-48) shl ((len-c) shl 2);
     end;
end;

function BinToInt(str1: string): integer;
var
  c: integer;
  len: integer;
  ch: char;  // one character of the string
begin
     result:=0;
     len:=length(str1);
     for c:=len downto 1 do
     begin
          ch:=str1[c];
          if ch='1' then
             result:=result+1 shl (len-c);
             // basically result:=result+(2 to the power of (len-c));
             // len-c is the digit of the number
     end;
end;

function OctalToInt(str1: string): integer;
var
  c: integer;
  len: integer;
  ch: char;  // one character of the string
begin
     result:=0;
     len:=length(str1);
     for c:=len downto 1 do
     begin
          ch:=str1[c];
          if (ch>='0')and(ch<='7') then
             result:=result+(ord(ch)-48) shl ((len-c)*3);
     end;
end;

function AsciiToInt(str1: string): integer;
var
  c: integer;
  len: integer;
  ch: char;  // one character of the string
begin
     result:=0;
     len:=length(str1);
     for c:=len downto 1 do
     begin
          ch:=str1[c];
          result:=result+ord(ch) shl ((len-c) shl 8);
     end;
end;
function IntToBin(i: integer): string;
var
  d: integer; // digit
  v: byte; // digit value
  n: boolean;
begin
     n:=(i<0);
     i:=abs(i);// make it positive
     d:=0;
     result:='';
     repeat
     begin
          v:=(i shr d) and 1; // v = 0..1
          result:=chr(v+48)+result;
          inc(d);
     end;
     until (i<(1 shl d));
     if n then
        result:='-'+result;
end;

function IntToOctal(i: integer): string;
var
  d: integer; // digit
  v: byte; // digit value
  n: boolean;
begin
     n:=(i<0);
     i:=abs(i);// make it positive
     d:=0;
     result:='';
     repeat
     begin
          v:=(i shr d) and 7; // v = 0..7
          result:=chr(v+48)+result;
          inc(d,3);
     end;
     until (i<(1 shl d));
     if n then
        result:='-'+result;
end;

function IntToHex(i: integer): string;
var
  d: integer; // digit
  v: byte; // digit value
  n: boolean;
begin
     n:=(i<0);
     i:=abs(i);// make it positive
     d:=0;
     result:='';
     repeat
     begin
          v:=(i shr d) and $F; // v = 0..15
          if v>9 then  // 'A' .. 'F'
             result:=chr(v+55)+result
          else   // '0'..'9'
             result:=chr(v+48)+result;
          inc(d,4);
     end;
     until (i<(1 shl d));
     if n then
        result:='-'+result;
end;

function IntToAscii(i: integer): string;
var
  d: integer; // digit
  v: byte; // digit value
  n: boolean;
begin
     n:=(i<0);
     i:=abs(i);// make it positive
     d:=0;
     result:='';
     repeat
     begin
          v:=(i shr d) and $ff; // v = 0..1
          result:=chr(v)+result;
          inc(d,8);
     end;
     until (i<(1 shl d));
     if n then
        result:='-'+result;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  InputValue: integer;
  s: string;
begin
     s:=edit1.text;
     Case RadioGroup1.ItemIndex of
       0: InputValue:=BinToInt(s);
       1: InputValue:=OctalToInt(s);
       2: InputValue:=StrToInt(s);
       3: InputValue:=HexToInt(s);
       4: InputValue:=AsciiToInt(s);
     end;
     Case RadioGroup2.ItemIndex of
       0: Label1.Caption:=IntToBin(InputValue);
       1: Label1.Caption:=IntToOctal(InputValue);
       2: Label1.Caption:=IntToStr(InputValue);
       3: Label1.Caption:=IntToHex(InputValue);
       4: Label1.Caption:=IntToAscii(InputValue);
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     //ShowMessage(inttostr(ord('0')));
end;

end.
