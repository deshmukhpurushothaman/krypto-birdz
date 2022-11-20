import { Input, Button } from '@chakra-ui/react'
import { useState } from 'react';
import classes from './Form.module.scss'

interface Props {
    mintBird: (kryptoBird: any) => any
}

const Form = (props: Props) => {
    const [kryptoBird, setKryptoBird] = useState<any>('');

    const mint = () => {
        props.mintBird(kryptoBird);
    }

    return (
        <div className={classes.container}>
            <Input placeholder='Basic usage' value={kryptoBird} onChange={(e) => setKryptoBird(e.target.value)} />
            <Button colorScheme='messenger' onClick={() => mint()}>Mint</Button>
        </div>
    )
}

export default Form;