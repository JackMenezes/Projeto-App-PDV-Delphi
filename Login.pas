unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFrmLogin = class(TForm)
    LConteudo: TLayout;
    ImgBack: TImage;
    LConteudoLogin: TLayout;
    LImagem: TLayout;
    LLogo: TLayout;
    ImgLogo: TImage;
    LUsuario: TLayout;
    ImgUsuario: TImage;
    ImgIcone: TImage;
    edtUsuario: TEdit;
    LSenha: TLayout;
    imgSenha: TImage;
    imgIconeSenha: TImage;
    edtSenha: TEdit;
    LBotao: TLayout;
    imgBotao: TImage;
    Label1: TLabel;
    procedure imgBotaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses Modulo, Menu;
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFrmLogin.imgBotaoClick(Sender: TObject);
begin
  if Trim(EdtUsuario.Text) = '' then
     begin
         showMessage('Preencha o Usuário!');
         EdtUsuario.SetFocus;
         exit;
     end;

      if Trim(EdtSenha.Text) = '' then
     begin
        showMessage('Preencha a Senha!');
         EdtSenha.SetFocus;
         exit;
     end;


      dm.query_usuarios.Close;
       dm.query_usuarios.SQL.Clear;
       dm.query_usuarios.SQL.Add('SELECT * from usuarios where usuario = :usuario and senha = :senha');
        dm.query_usuarios.ParamByName('usuario').Value := edtUsuario.Text;
         dm.query_usuarios.ParamByName('senha').Value := edtSenha.Text;
       dm.query_usuarios.Open;

       if not dm.query_usuarios.isEmpty then
       begin



         nomeUsuario :=  dm.query_usuarios['nome'];
         cargoUsuario :=  dm.query_usuarios['cargo'];

         if (cargoUsuario = 'admin') or (cargoUsuario = 'Gerente') then
         begin

         FrmMenu := TFrmMenu.Create(self);
         FrmMenu.Show;

         end
         else
         begin
         showMessage('Você não tem permissão para acessar!!');
           edtusuario.Text := '';
           EdtSenha.Text := '';
           edtUsuario.SetFocus;
           exit;
         end;



          end
          else
          begin
           showMessage('Os dados estão incorretos!!');
           edtusuario.Text := '';
           EdtSenha.Text := '';
           edtUsuario.SetFocus;
       end;


end;

end.
