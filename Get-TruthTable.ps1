function Get-TruthTable{
    Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("OR","AND","XOR","NOT","EQ","IMPLY")]
    [string[]]
    $Operation,
    [Parameter(Mandatory=$true)]
    [ValidateSet("TAUT","CON","NOT","NONE")]
    [string[]]
    $PMod,
    [Parameter(Mandatory=$true)]
    [ValidateSet("TAUT","CON","NOT","NONE")]
    [string[]]
    $QMod
)
    
    #INIT Tables
    $P = @($true,$true,$false,$false)
    $Q = @($true,$false,$true,$false)

    switch($PMod)
    {

        "TAUT" {$i = 0;while($i -lt 4){$P[$i] = $true;$i++}; break}
        "CON"  {$i = 0;while($i -lt 4){$P[$i] = $false;$i++}; break}
        "NOT"  {$i = 0;while($i -lt 4){$P[$i] = !$P[$i];$i++}; break}
        "NONE" {break}
    
    }

    switch($QMod)
    {

        "TAUT" {$i = 0;while($i -lt 4){$Q[$i] = $true;$i++}; break}
        "CON"  {$i = 0;while($i -lt 4){$Q[$i] = $false;$i++}; break}
        "NOT"  {$i = 0;while($i -lt 4){$Q[$i] = !$Q[$i];$i++}; break}
        "NONE" {break}
    
    }


    #GENERATER RESULT TRUTH TABLE
    $RESULT = @()

    $i = 0
    while($i -lt 4)
    {

        $OP_OUTPUT = $false

        switch($Operation)
        {
        
            "OR"    {$OP_OUTPUT = $P[$i] -or $Q[$i];break}
            "AND"   {$OP_OUTPUT = $P[$i] -and $Q[$i];break}
            "XOR"   {$OP_OUTPUT = $P[$i] -xor $Q[$i];break}
            "NOT"   {$OP_OUTPUT = $P[$i] -ne $Q[$i];break}
            "EQ"    {$OP_OUTPUT = $P[$i] -eq $Q[$i];break}
            "IMPLY" {if(!$P[$i] -or $Q[$i]){$OP_OUTPUT = $true};break}

        }

        $RESULT += [PSCustomObject]@{
        P  = $P[$i]
        Q  = $Q[$i]
        OP = $OP_OUTPUT
        }
        $i++
    }

    return $RESULT
}
