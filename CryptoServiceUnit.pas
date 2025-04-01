{*******************************************************
* Project: VistaMedTools2
* Unit: CryptoServiceUnit.pas
* Description: сервис шифроания данных
*
* Created: 01.04.2025 15:13:47
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit CryptoServiceUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils;

type
  /// <summary>TCryptoService
  /// сервис шифроания данных
  /// </summary>
  TCryptoService = class
  public
    /// <summary>TCryptoService.EncryptString
    /// зашифровать строку
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASource"> (string) исходная строка</param>
    /// <param name="APassword"> (string) пароль</param>
    class function EncryptString(ASource, APassword: string): string;
    /// <summary>TCryptoService.DecryptString
    /// расшифровать строку
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASource"> (string) зашифрованная строка</param>
    /// <param name="APassword"> (string) пароль</param>
    class function DecryptString(ASource, APassword: string): string;
  end;

implementation

uses
  DCPblowfish, DCPsha512, DCPcrypt2;

class function TCryptoService.DecryptString(ASource, APassword: string): string;
var
  vChipher: TDCP_blowfish;
begin
  vChipher := TDCP_blowfish.Create(nil);
  try
    vChipher.InitStr(APassword, TDCP_sha512);
    Result := vChipher.DecryptString(ASource);
  finally
    vChipher.Free;
  end;
end;

class function TCryptoService.EncryptString(ASource, APassword: string): string;
var
  vChipher: TDCP_blowfish;
begin
  vChipher := TDCP_blowfish.Create(nil);
  try
    vChipher.InitStr(APassword, TDCP_sha512);
    Result := vChipher.EncryptString(ASource);
  finally
    vChipher.Free;
  end;
end;

end.
