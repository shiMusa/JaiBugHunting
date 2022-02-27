#import "Basic";



get_type_string :: (info: *Type_Info) -> string {
    if info.type == {
    case .INTEGER;
        int_info := cast(*Type_Info_Integer)info;
        if int_info.signed {
            if int_info.runtime_size == {
            case 1; return "s8";
            case 2; return "s16";
            case 4; return "s32";
            case 8; return "s64";
            }
        } else {
            if int_info.runtime_size == {
            case 1; return "u8";
            case 2; return "u16";
            case 4; return "u32";
            case 8; return "u64";
            }
        }
    case .FLOAT;
        float_info := cast(*Type_Info_Float)info;
        if float_info.runtime_size == {
        case 4; return "float32";
        case 8; return "float64";
        }
    case .BOOL;
        return "bool";
    }
    return "";
}



parse_bytes :: (builder: *String_Builder, info: *Type_Info, val: *u8, end: string = ", ") {
    if info.type == {
    case .INTEGER;
        int_info := cast(*Type_Info_Integer)info;
        if int_info.signed {
            if int_info.runtime_size == {
            case 1; print_to_builder(builder, "%", <<(cast(*s8 )val));
            case 2; print_to_builder(builder, "%", <<(cast(*s16)val));
            case 4; print_to_builder(builder, "%", <<(cast(*s32)val));
            case 8; print_to_builder(builder, "%", <<(cast(*s64)val));
            }
        } else {
            if int_info.runtime_size == {
            case 1; print_to_builder(builder, "%", <<(cast(*u8 )val));
            case 2; print_to_builder(builder, "%", <<(cast(*u16)val));
            case 4; print_to_builder(builder, "%", <<(cast(*u32)val));
            case 8; print_to_builder(builder, "%", <<(cast(*u64)val));
            }
        }
    case .FLOAT;
        float_info := cast(*Type_Info_Float)info;
        if float_info.runtime_size == {
        case 4; print_to_builder(builder, "%", <<(cast(*float32)val));
        case 8; print_to_builder(builder, "%", <<(cast(*float64)val));
        }
    case .BOOL;
        print_to_builder(builder, "%", <<(cast(*bool)val));
    case .STRING;
        print_to_builder(builder, "\"%\"", <<(cast(*string)val));
    case .TYPE;
        print_to_builder(builder, "%", <<(cast(*Type)val));
    case .ENUM;
        enum_info := cast(*Type_Info_Enum)info;

        name : string = ---;
        for enum_info.values {
            if it == <<(cast(*s64)val) {
                name = enum_info.names[it_index];
                break;
            }
        }

        print_to_builder(builder, "%.%", enum_info.name, name);
    case .ARRAY;
        array_info := cast(*Type_Info_Array)info;
        print_to_builder(builder, "%.[", get_type_string(array_info.element_type));
        
        if array_info.array_type == .FIXED {
            print("there are % elements in the FIXED array\n", array_info.array_count);
            print("elements are %\n", <<array_info.element_type);
            offset := 0;
            for 0..array_info.array_count-1 {
                parse_bytes(builder, array_info.element_type, val + offset, "");
                if it != array_info.array_count-1 then append(builder, ", ");
                offset += array_info.element_type.runtime_size;
            }
        } else {
            view := cast(*Array_View_64)val;
            print("view = %\n", <<view);

            offset := 0;
            for 0..view.count-1 {
                parse_bytes(builder, array_info.element_type, view.data + offset, "");
                if it != view.count-1 then append(builder, ", ");
                offset += array_info.element_type.runtime_size;
            }
        }
        
        append(builder, "]");
    case .STRUCT;
        struct_info := cast(*Type_Info_Struct)info;
        print("struct_info = %\n", <<struct_info);

        print_to_builder(builder, "%", struct_info.name);
        if struct_info.polymorph_source_struct != null {
            append(builder, "(");
            for struct_info.specified_parameters {
                print("parameters    % : %\n", it.name, <<it.type);
                parse_bytes(builder, it.type, struct_info.constant_storage_buffer + it.offset_into_constant_storage, "");
                if it_index != struct_info.specified_parameters.count-1 then append(builder, ", ");
            }
            append(builder, ")");
        }
        append(builder, ".{\n");

        for struct_info.members {
            print("member type = %\n", <<it.type);
            parse_bytes(builder, it.type, val + it.offset_in_bytes, "");
            if it_index != struct_info.members.count-1 then append(builder, ",");
            append(builder, "\n");
        }

        append(builder, "}");
    case .POINTER;
        assert(false, "Cannot construct compile-time constant variable with pointers! (yet?)\n");
    }

    append(builder, end);
}



construct :: (val: $T, end: string = ";\n") -> string {
    builder : String_Builder;
    init_string_builder(*builder);
    defer free_buffers(*builder);

    info := type_info(T);

    print("T              = %\n", T);
    print("val            = %\n", val);
    print("<<type_info(T) = %\n", <<info);
    print("----------------------------------\n");

    parse_bytes(*builder, info, cast(*u8)(*val), ";\n");

    res := builder_to_string(*builder);
    print("%\n", res);
    return res;
}



Foo :: struct {
    val: int;
    arr: [6]float64;
}

Bar :: struct(T: Type) {
    val: T;
}


Options :: enum {
    ON;
    OFF;
    UNDECIDED;
}

Results :: enum u8 {
    OK;
    ERROR;
    WARNING;
    MAYBE;
    PROBABLY;
    NOT;
}

Complex :: struct(T: Type, N: int) {
    vals: [N]T;
    doit: Options = .UNDECIDED;
    msg: string = "Hello World";
    view: []u8;
}

main :: () {
    t_int : u8 : #insert #run construct(42);
    print("%\n", t_int);
    
    t_float : float64 : #insert #run construct(3.131);
    print("%\n", t_float);
    
    t_bool : bool : #insert #run construct(false);
    print("%\n", t_bool);
    
    t_string : string : #insert #run construct("Hello World");
    print("%\n", t_string);

    t_arr_i :: #insert #run construct(u8.[5,4,3,2,1]);
    print("%\n", t_arr_i);

    t_arr_i2 :: #insert #run () -> string {
        res := NewArray(5, u8, false);
        defer array_free(res);
        for 0..4 { res[it] = cast(u8)it; }
        print("array view = %\n", res);
        return construct(res);
    }();
    print("%\n", t_arr_i2);

    t_arr_f :: #insert #run construct(float64.[5.0,4.0,3.0,2.0,1.0]);
    print("%\n", t_arr_f);

    t_struct :: #insert #run () -> string {
        f : Foo = ---;
        f.val = 42;
        f.arr = float64.[1.0,2.0,3.0,4.0,5.0,6.0];
        return construct(f);
    }();
    print("%\n", t_struct);

    t_poly_struct :: #insert #run () -> string {
        b : Bar(s8) = ---;
        b.val = -2;
        return construct(b);
    }();
    print("%\n", t_poly_struct);

    t_enum :: #insert #run () -> string {
        e := Options.OFF;
        return construct(e);
    }();
    print("%\n", t_enum);

    t_enum_u8 :: #insert #run () -> string {
        e := Results.MAYBE;
        return construct(e);
    }();
    print("%\n", t_enum_u8);

    t_compelx :: #insert #run () -> string {
        c : Complex(s16, 4);
        c.vals = s16.[-2,-1,0,1];
        c.doit = Options.ON;

        data := NewArray(3, u8, false);
        data[0] = #char "a";
        data[1] = #char "A";
        data[2] = #char "0";
        c.view = data;

        return construct(c);
    }();
    print("%\n", t_compelx);
}