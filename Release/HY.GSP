<?xml version="1.0" encoding="utf-8"?>
<GSPModel GSPModelNode="True" DataFormatVersion="2.3.7" BizVersion="" xmlns:a="attribute" xmlns:c="collection" xmlns:o="object">
    <a:Version>2.3.7</a:Version>
    <a:Name>GSPModel</a:Name>
    <a:Mode>2</a:Mode>
    <c:Databases>
        <o:Database>
            <a:Name>DB</a:Name>
            <c:Tables>
                <o:Table TableKind="0">
                    <o:TableSchema>
                        <a:Name>Person</a:Name>
                        <a:CommandEnable>True</a:CommandEnable>
                        <a:ApplyUpdateEnabled>False</a:ApplyUpdateEnabled>
                        <a:PrimaryKeyMinVal>1</a:PrimaryKeyMinVal>
                        <c:FieldSchemas>
                            <o:FieldSchema FieldKind="0">
                                <a:FieldName>PersonID</a:FieldName>
                                <a:DataType>2</a:DataType>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>Name</a:FieldName>
                                <a:StrLength>10</a:StrLength>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>QQ</a:FieldName>
                                <a:StrLength>255</a:StrLength>
                            </o:FieldSchema>
                        </c:FieldSchemas>
                    </o:TableSchema>
                    <o:TableData>
                        <a:CompressData>True</a:CompressData>
                        <o:Records>eAEtzMtqAkEQheETEZkZNb5KVVdXX57XTVZBBBGDhgkkqKCiBH0Bl1FRgkIWgYxNNmfx/XC+ADygVi0a8/VxcBwgc2K8s9ZV4c6jn8nTqofMkKqQj6gnLk/lrbwhl0DimKxB9u+v/dkeeTTWEwUNKJIPnz8vwzEyy55ELKGZeNfdTFfvKJg5amDvGK0U3q7r/cuhCiQxCLNTtO+hvjsszsirEy9MkfCYdHndfCNXtSYYioxO0u3H7BeF0aCO1QX/B4aNQCI=</o:Records>
                    </o:TableData>
                </o:Table>
                <o:Table TableKind="0">
                    <o:TableSchema>
                        <a:Name>Feedback</a:Name>
                        <a:DisplayName>反馈</a:DisplayName>
                        <a:CommandEnable>True</a:CommandEnable>
                        <a:ApplyUpdateEnabled>False</a:ApplyUpdateEnabled>
                        <a:PrimaryKeyMinVal>1</a:PrimaryKeyMinVal>
                        <c:FieldSchemas>
                            <o:FieldSchema FieldKind="0">
                                <a:FieldName>FeedbackID</a:FieldName>
                                <a:DataType>2</a:DataType>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="1">
                                <a:FieldName>PersonID</a:FieldName>
                                <a:DataType>2</a:DataType>
                                <a:LookupKind>1</a:LookupKind>
                                <a:LookupTableName>Person</a:LookupTableName>
                                <a:LookupResult>PersonID</a:LookupResult>
                                <a:LookupDescription>Name</a:LookupDescription>
                                <a:MasterTableName>Person</a:MasterTableName>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>Date</a:FieldName>
                                <a:DataType>9</a:DataType>
                            </o:FieldSchema>
                        </c:FieldSchemas>
                    </o:TableSchema>
                    <o:TableData>
                        <a:CompressData>True</a:CompressData>
                        <o:Records>eAGzYmBgYGRgBpIM/CACBA6ce+LAwARigQkQgwEkxAhiwIUagEIAsJcHaw==</o:Records>
                    </o:TableData>
                </o:Table>
                <o:Table TableKind="1">
                    <o:TableSchema>
                        <a:Name>Option</a:Name>
                        <a:CommandEnable>True</a:CommandEnable>
                        <a:ApplyUpdateEnabled>False</a:ApplyUpdateEnabled>
                        <c:FieldSchemas>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>MeetingMsg</a:FieldName>
                                <a:DisplayName>开会信息</a:DisplayName>
                                <a:StrLength>255</a:StrLength>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>MeetingTime</a:FieldName>
                                <a:DisplayName>开会时间</a:DisplayName>
                                <a:StrLength>255</a:StrLength>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>FeedbackMsg</a:FieldName>
                                <a:DisplayName>反馈提示信息</a:DisplayName>
                                <a:StrLength>255</a:StrLength>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>WeatherTime</a:FieldName>
                                <a:DisplayName>天气时间</a:DisplayName>
                                <a:StrLength>255</a:StrLength>
                            </o:FieldSchema>
                        </c:FieldSchemas>
                    </o:TableSchema>
                    <o:TableData>
                        <a:CompressData>True</a:CompressData>
                        <o:Records>eAHLZWBgYGTg2L/q/LLdDxcuZmA1NLUyNmUIWrjtwoVLW/cc23N77+6D369tPLti89aF2/d+PPMmLzE3dcuyA2+3bzmwcOFiXi79ovziVCIIoNEmVgZmAIDiNJY=</o:Records>
                    </o:TableData>
                </o:Table>
                <o:Table TableKind="0">
                    <o:TableSchema>
                        <a:Name>FeedbackWeek</a:Name>
                        <a:DisplayName>反馈按周</a:DisplayName>
                        <a:CommandEnable>True</a:CommandEnable>
                        <a:ApplyUpdateEnabled>False</a:ApplyUpdateEnabled>
                        <a:PrimaryKeyMinVal>1</a:PrimaryKeyMinVal>
                        <c:FieldSchemas>
                            <o:FieldSchema FieldKind="0">
                                <a:FieldName>FeedbackID</a:FieldName>
                                <a:DataType>2</a:DataType>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="1">
                                <a:FieldName>PersonID</a:FieldName>
                                <a:DataType>2</a:DataType>
                                <a:LookupKind>1</a:LookupKind>
                                <a:LookupTableName>Person</a:LookupTableName>
                                <a:LookupResult>PersonID</a:LookupResult>
                                <a:LookupDescription>Name</a:LookupDescription>
                                <a:MasterTableName>Person</a:MasterTableName>
                            </o:FieldSchema>
                            <o:FieldSchema FieldKind="2">
                                <a:FieldName>Date</a:FieldName>
                                <a:DataType>9</a:DataType>
                            </o:FieldSchema>
                        </c:FieldSchemas>
                    </o:TableSchema>
                    <o:TableData>
                        <a:CompressData>True</a:CompressData>
                        <o:Records>eAFTZ2BgYGRgApJACgoazj9xgPDA4iDRBeeeOAAAQ2UFNA==</o:Records>
                    </o:TableData>
                </o:Table>
            </c:Tables>
        </o:Database>
    </c:Databases>
</GSPModel>
