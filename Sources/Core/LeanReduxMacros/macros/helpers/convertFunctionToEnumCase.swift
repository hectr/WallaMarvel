import SwiftSyntax

/// Converts a function declaration into an enum case.
///
/// **Note:** This function will skip the `inout` parameter.
///
/// - Parameters:
///   - functionDeclaration: The function declaration to convert.
/// - Returns: The enum case representing the function.
///
func convertFunctionToEnumCase(functionDeclaration: FunctionDeclSyntax) -> EnumCaseElementSyntax
{
    let actionName = functionDeclaration.name.text

    // Build associated value from the function parameters (excluding `inout` parameters)
    let assocParams = functionDeclaration.signature.parameterClause.parameters.compactMap { param -> FunctionParameterSyntax? in
        let type = param.type.description.trimmingCharacters(in: .whitespacesAndNewlines)
        if type.contains("inout") {
            // skip `inout` parameter
            return nil
        }
        return param
    }

    // Convert them to an AssociatedValue for the enum.
    // e.g. (id: String), (x: Int, y: Int)
    let assocValue: FunctionParameterClauseSyntax? = assocParams.isEmpty
    ? nil
    : FunctionParameterClauseSyntax(
        parameters: FunctionParameterListSyntax(
            assocParams.map { p in
                FunctionParameterSyntax(
                    firstName: p.firstName,
                    secondName: p.secondName,
                    colon: p.colon,
                    type: p.type.withoutEscaping()
                )
            }
        )
    )

    let lastAssocParamsIndex = assocParams.indices.last

    return EnumCaseElementSyntax(
        name: .identifier(actionName),
        parameterClause: assocValue.map { value in
            // Turn `FunctionParameterListSyntax ` (`FunctionParameterClauseSyntax`) into an `EnumCaseParameterListSyntax`
            let paramList = value.parameters.enumerated().map { offset, param in
                EnumCaseParameterSyntax(
                    firstName: param.firstName,
                    colon: param.colon,
                    type: param.type,
                    trailingComma: offset == lastAssocParamsIndex ? nil : .commaToken()
                )
            }
            return EnumCaseParameterClauseSyntax(parameters: EnumCaseParameterListSyntax(paramList))
        }
    )
}
