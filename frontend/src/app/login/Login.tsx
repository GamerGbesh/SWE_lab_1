"use client"
import Link from "next/link";
import {useActionState, useEffect} from "react"
import loginUser from "@/app/login/actions";
import {redirect} from "next/navigation";

const initialMessage = {success: false, message: ""}

export default function Login() {
    const [state, formState] = useActionState(loginUser, initialMessage);

    useEffect(() => {
        if (state.success) {
            redirect("/");
        }
    }, [state.success]);

    return (
        <div className="max-w-md mx-auto p-4 bg-gray-200 shadow-2xl rounded-lg relative top-30">
            <form action={formState} className="grid place-items-center h-full gap-4">
                <label htmlFor="username">Username</label>
                <input type={"text"} placeholder={"Username"} id={"username"} name={"username"} className={"border rounded-2xl px-4 border-blue-300"}/>

                <label htmlFor="password">Password</label>
                <input type="password" placeholder={"Password"} id={"password"} name={"password"} className={"border rounded-2xl px-4 border-blue-300"}/>

                <button type={"submit"} className={"bg-blue-900 p-1 rounded-2xl px-6 cursor-pointer"}>Login</button>
                <p>Don&#39;t have an account? <Link href={"/register"} className={"text-blue-700"}><span>Signup</span></Link></p>
            </form>
            {state.message && (
                <p className={`mt-2 text-sm ${state.success ? 'text-green-600' : 'text-red-600'}`}>
                    {state.message}
                </p>
            )}
        </div>
    );
}